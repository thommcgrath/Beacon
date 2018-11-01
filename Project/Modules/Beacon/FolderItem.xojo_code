#tag Class
Protected Class FolderItem
	#tag Method, Flags = &h0
		Function Child(Name As Text) As Beacon.FolderItem
		  #if TargetiOS
		    Return Self.mSource.Child(Name)
		  #else
		    Return Self.mLegacySource.Child(Name)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Children() As Xojo.Core.Iterable
		  Dim Items As Beacon.Collection
		  #if TargetiOS
		    For Each Child As Xojo.IO.FolderItem In Self.mSource.Children
		      Dim Converted As Beacon.FolderItem = Child
		      Items.Append(Converted)
		    Next
		  #else
		    For I As Integer = 0 To Self.mLegacySource.Count
		      Dim Converted As Beacon.FolderItem = Self.mLegacySource.Item(I)
		      Items.Append(Converted)
		    Next
		  #endif
		  Return Items
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(FromPath As Text)
		  #if TargetiOS
		    Self.mSource = New Xojo.IO.FolderItem(FromPath)
		  #else
		    If FromPath.BeginsWith("file://") Then
		      Self.mLegacySource = GetFolderItem(FromPath, Global.FolderItem.PathTypeURL)
		    Else
		      Self.mLegacySource = GetFolderItem(FromPath, Global.FolderItem.PathTypeNative)
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  #if TargetiOS
		    Return Self.mSource.Count
		  #else
		    Return Self.mLegacySource.Count
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateAsFolder()
		  #if TargetiOS
		    Self.mSource.CreateAsFolder
		  #else
		    Self.mLegacySource.CreateAsFolder
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Shared Sub DeepDelete(File As Global.FolderItem)
		  Dim C As Integer = File.Count
		  For I As Integer = C DownTo 0
		    DeepDelete(File.Item(I))
		  Next
		  File.Delete
		  
		  Dim Err As IOException = ErrorCodeToException(File.LastErrorCode)
		  If Err <> Nil Then
		    Raise Err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Private Shared Sub DeepDelete(File As Xojo.IO.FolderItem)
		  For Each Child As Xojo.IO.FolderItem In File.Children
		    DeepDelete(Child)
		  Next
		  File.Delete
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete(Deep As Boolean = False)
		  #if TargetiOS
		    If Deep Then
		      Self.DeepDelete(Self.mSource)
		    Else
		      Self.mSource.Delete
		    End If
		  #else
		    If Deep Then
		      Self.DeepDelete(Self.mLegacySource)
		    Else
		      Self.mLegacySource.Delete
		      
		      Dim Err As IOException = Self.ErrorCodeToException(Self.mLegacySource.LastErrorCode)
		      If Err <> Nil Then
		        Raise Err
		      End If
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If Self.mIsTemporary And Self.Exists Then
		    Self.Delete(True)
		  End If
		  
		  #if TargetMacOS
		    If Self.mBookmark <> Nil Then
		      Declare Function StopAccessingSecurityScopedResource Lib "Cocoa" Selector "stopAccessingSecurityScopedResource" (Target As Ptr) As Boolean
		      Call StopAccessingSecurityScopedResource(Self.mBookmark)
		      
		      Declare Sub Release Lib "Cocoa" Selector "release" (Target As Ptr)
		      Release(Self.mBookmark)
		      
		      Self.mBookmark = Nil
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As Text
		  #if TargetiOS
		    Return Self.mSource.DisplayName
		  #else
		    Return Self.mLegacySource.DisplayName.ToText
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ErrorCodeToException(Code As Integer) As IOException
		  If Code = Global.FolderItem.NoError Then
		    Return Nil
		  End If
		  
		  Dim Err As New IOException
		  Err.ErrorNumber = Code
		  Select Case Code
		  Case Global.FolderItem.DestDoesNotExistError
		    Err.Reason = "The destination does not exist"
		  Case Global.FolderItem.FileNotFound
		    Err.Reason = "File not found"
		  Case Global.FolderItem.AccessDenied
		    Err.Reason = "Permission denied"
		  Case Global.FolderItem.NotEnoughMemory
		    Err.Reason = "Out of memory"
		  Case Global.FolderItem.FileInUse
		    Err.Reason = "File is in use"
		  Case Global.FolderItem.InvalidName
		    Err.Reason = "Filename is invalid"
		  Else
		    Err.Reason = "Other error #" + Code.ToText
		  End Select
		  Return Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Exists() As Boolean
		  #if TargetiOS
		    Return Self.mSource <> Nil And Self.mSource.Exists
		  #else
		    Return Self.mLegacySource <> Nil And Self.mLegacySource.Exists
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Extension() As Text
		  Dim Name As Text = Self.Name
		  If Name.IndexOf(".") = -1 Then
		    Return ""
		  End If
		  
		  Dim Parts() As Text = Name.Split(".")
		  Return Parts(Parts.Ubound)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveInfo(SaveInfo As Text) As Beacon.FolderItem
		  #if TargetiOS
		    Return Nil
		  #else
		    Declare Function objc_getClass Lib "Cocoa" (ClassName As CString) As Ptr
		    Declare Function URLByResolvingBookmarkData Lib "Cocoa" Selector "URLByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:" (Target As Ptr, BookmarkData As Ptr, Options As UInt32, RelativeURL As Ptr, IsStale As Boolean, ByRef Error As Ptr) As Ptr
		    Declare Function DataWithBytes Lib "Cocoa" Selector "initWithBytes:length:" (Target As Ptr, Bytes As Ptr, Length As UInteger) As Ptr
		    Declare Function AbsoluteString Lib "Cocoa" Selector "absoluteString" (Target As Ptr) As CFStringRef
		    Declare Function Alloc Lib "Cocoa" Selector "alloc" (Target As Ptr) As Ptr
		    Declare Sub Autorelease Lib "Cocoa" Selector "autorelease" (Target As Ptr)
		    Declare Function StartAccessingSecurityScopedResource Lib "Cocoa" Selector "startAccessingSecurityScopedResource" (Target As Ptr) As Boolean
		    
		    Dim Mem As MemoryBlock = Beacon.ConvertMemoryBlock(Beacon.DecodeBase64(SaveInfo))
		    Dim DataRef As Ptr = DataWithBytes(Alloc(objc_getClass("NSData")), Mem, Mem.Size)
		    Autorelease(DataRef)
		    
		    Dim ErrorRef As Ptr
		    Dim FileURL As Ptr = URLByResolvingBookmarkData(objc_getClass("NSURL"), DataRef, 1024, Nil, False, ErrorRef)
		    If FileURL <> Nil And StartAccessingSecurityScopedResource(FileURL) Then
		      Declare Function Retain Lib "Cocoa" Selector "retain" (Target As Ptr) As Ptr
		      Call Retain(FileURL)
		      
		      Dim Path As String = AbsoluteString(FileURL)
		      Dim File As Beacon.FolderItem = GetFolderItem(Path, Global.FolderItem.PathTypeURL)
		      File.mBookmark = FileURL
		      Return File
		    Else
		      Declare Function ErrorCode Lib "Cocoa" Selector "code" (Target As Ptr) As Integer
		      Declare Function ErrorDescription Lib "Cocoa" Selector "localizedDescription" (Target As Ptr) As CFStringRef
		      App.Log("Unable to resolve saveinfo for: " + Str(ErrorCode(ErrorRef)) + " " + ErrorDescription(ErrorRef))
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsFolder() As Boolean
		  #if TargetiOS
		    Return Self.mSource.IsFolder
		  #else
		    Return Self.mLegacySource.Directory
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function IsType(Type As FileType) As Boolean
		  Return Self.Name.EndsWith(Type.PrimaryExtension.ToText)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Length() As UInt64
		  #if TargetiOS
		    Return Self.mSource.Length
		  #else
		    Return Self.mLegacySource.Length
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  #if TargetiOS
		    Return Self.mSource.Name
		  #else
		    Return Self.mLegacySource.Name.ToText
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.FolderItem) As Integer
		  #if TargetiOS
		    If Other = Nil And Self.mSource = Nil Then
		      Return 0
		    ElseIf Other = Nil And Self.mSource <> Nil Then
		      Return 1
		    ElseIf Other <> Nil And Self.mSource = Nil Then
		      Return -1
		    Else
		      Return StrComp(Self.mSource.Path, Other.Path, 0)
		    End If
		  #else
		    If Other = Nil And Self.mLegacySource = Nil Then
		      Return 0
		    ElseIf Other = Nil And Self.mLegacySource <> Nil Then
		      Return 1
		    ElseIf Other <> Nil And Self.mLegacySource = Nil Then
		      Return -1
		    Else
		      Return StrComp(Self.mLegacySource.NativePath, Other.Path, 0)
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function Operator_Convert() As Global.FolderItem
		  Return Self.mLegacySource
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Function Operator_Convert() As Xojo.IO.FolderItem
		  Return Self.mSource
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub Operator_Convert(Source As Global.FolderItem)
		  Self.mLegacySource = Source
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Sub Operator_Convert(Source As Xojo.IO.FolderItem)
		  Self.mSource = Source
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As Text
		  #if TargetiOS
		    Return Self.mSource.Path
		  #else
		    Return Self.mLegacySource.NativePath.ToText
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Length As Integer = -1) As Xojo.Core.MemoryBlock
		  #if TargetiOS
		    Dim Stream As Xojo.IO.BinaryStream = Xojo.IO.BinaryStream.Open(Self.mSource, Xojo.IO.BinaryStream.LockModes.Read)
		    If Length <= 0 Then
		      Length = Stream.Length
		    Else
		      Length = Min(Stream.Length, Length)
		    End If
		    Dim Content As Xojo.Core.MemoryBlock = Stream.Read(Length)
		    Stream.Close
		    Return Content
		  #else
		    Dim Stream As BinaryStream = BinaryStream.Open(Self.mLegacySource, False)
		    If Length <= 0 Then
		      Length = Stream.Length
		    Else
		      Length = Min(Stream.Length, Length)
		    End If
		    Dim Content As Global.MemoryBlock = Stream.Read(Length, Nil)
		    Stream.Close
		    
		    Dim Mem As New Xojo.Core.MemoryBlock(Content)
		    Return Mem.Left(Content.Size)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Encoding As Xojo.Core.TextEncoding) As Text
		  Dim Content As Xojo.Core.MemoryBlock = Self.Read()
		  Return Encoding.ConvertDataToText(Content, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SanitizeFilename(Filename As Text) As Text
		  Filename = Filename.ReplaceAll("/", "-")
		  Filename = Filename.ReplaceAll("\", "-")
		  Filename = Filename.ReplaceAll(":", "-")
		  Return Filename
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveInfo() As Text
		  #if TargetiOS
		    Return ""
		  #else
		    Declare Function objc_getClass Lib "Cocoa" (ClassName As CString) As Ptr
		    Declare Function URLWithString Lib "Cocoa" Selector "URLWithString:" (Target As Ptr, URLString As CFStringRef) As Ptr
		    Declare Function BookmarkDataWithOptions Lib "Cocoa" Selector "bookmarkDataWithOptions:includingResourceValuesForKeys:relativeToURL:error:" (Target As Ptr, Options as UInt32, ResourceValuesKeys As Ptr, RelativeURL As Ptr, ByRef Error As Ptr) As Ptr
		    Declare Function DataLength Lib "Cocoa" Selector "length" (Target As Ptr) As UInteger
		    Declare Sub DataBytes Lib "Cocoa" Selector "getBytes:length:" (Target As Ptr, Buffer As Ptr, Length As UInteger)
		    
		    Dim ErrorRef as Ptr
		    Dim NSURL As Ptr = objc_getClass("NSURL")
		    Dim FileURL As Ptr = URLWithString(NSURL, Self.mLegacySource.URLPath)
		    If FileURL <> Nil Then
		      Dim DataRef As Ptr = BookmarkDataWithOptions(FileURL, 2048, Nil, Nil, ErrorRef)
		      If DataRef <> Nil Then
		        Dim Mem As New Global.MemoryBlock(DataLength(DataRef))
		        DataBytes(DataRef, Mem, Mem.Size)
		        Return Beacon.EncodeBase64(Beacon.ConvertMemoryBlock(Mem))
		      Else
		        Declare Function ErrorCode Lib "Cocoa" Selector "code" (Target As Ptr) As Integer
		        Declare Function ErrorDescription Lib "Cocoa" Selector "localizedDescription" (Target As Ptr) As CFStringRef
		        App.Log("Unable to get saveinfo for " + Self.mLegacySource.NativePath + ": " + Str(ErrorCode(ErrorRef)) + " " + ErrorDescription(ErrorRef))
		      End If
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Temporary() As Beacon.FolderItem
		  Dim Item As Beacon.FolderItem
		  #if TargetiOS
		    Item = Xojo.IO.SpecialFolder.Temporary.Child(Beacon.CreateUUID)
		  #else
		    Item = SpecialFolder.Temporary.Child(Beacon.CreateUUID)
		  #endif
		  Item.mIsTemporary = True
		  Return Item
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URLPath() As Text
		  #if TargetiOS
		    Return Self.mSource.URLPath
		  #else
		    Return Self.mLegacySource.URLPath.ToText
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(Content As Text, Encoding As Xojo.Core.TextEncoding)
		  Self.Write(Encoding.ConvertTextToData(Content))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(Content As Xojo.Core.MemoryBlock)
		  #if TargetiOS
		    Dim Stream As Xojo.IO.BinaryStream = Xojo.IO.BinaryStream.Create(Self.mSource)
		    Stream.Write(Content)
		    Stream.Close
		  #else
		    Dim Stream As BinaryStream = BinaryStream.Create(Self.mLegacySource, True)
		    Stream.Write(CType(Content.Data, MemoryBlock).StringValue(0, Content.Size))
		    Stream.Close
		  #endif
		End Sub
	#tag EndMethod


	#tag Note, Name = Purpose
		
		This is a wrapper class so the classic framework can use classic folderitem
		and the new framework can use the new folderitem without worrying about
		the details.
		
		Why not just use all Xojo.IO.FolderItem? Because it doesn't work with non-ascii
		characters on Windows.
	#tag EndNote


	#tag Property, Flags = &h21
		Private mBookmark As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsTemporary As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mLegacySource As Global.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Private mSource As Xojo.IO.FolderItem
	#tag EndProperty


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
