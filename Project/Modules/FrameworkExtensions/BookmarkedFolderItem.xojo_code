#tag Class
Class BookmarkedFolderItem
Inherits FolderItem
	#tag Method, Flags = &h0
		Sub Destructor()
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
		Shared Function FromSaveInfo(SaveInfo As String) As BookmarkedFolderItem
		  #if TargetiOS
		    Return Nil
		  #elseif TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa" (ClassName As CString) As Ptr
		    Declare Function URLByResolvingBookmarkData Lib "Cocoa" Selector "URLByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:" (Target As Ptr, BookmarkData As Ptr, Options As UInt32, RelativeURL As Ptr, IsStale As Boolean, ByRef Error As Ptr) As Ptr
		    Declare Function DataWithBytes Lib "Cocoa" Selector "initWithBytes:length:" (Target As Ptr, Bytes As Ptr, Length As UInteger) As Ptr
		    Declare Function AbsoluteString Lib "Cocoa" Selector "absoluteString" (Target As Ptr) As CFStringRef
		    Declare Function Alloc Lib "Cocoa" Selector "alloc" (Target As Ptr) As Ptr
		    Declare Sub Autorelease Lib "Cocoa" Selector "autorelease" (Target As Ptr)
		    Declare Function StartAccessingSecurityScopedResource Lib "Cocoa" Selector "startAccessingSecurityScopedResource" (Target As Ptr) As Boolean
		    
		    Var Mem As MemoryBlock = DecodeBase64(SaveInfo)
		    Var DataRef As Ptr = DataWithBytes(Alloc(objc_getClass("NSData")), Mem, Mem.Size)
		    Autorelease(DataRef)
		    
		    Var ErrorRef As Ptr
		    Var FileURL As Ptr = URLByResolvingBookmarkData(objc_getClass("NSURL"), DataRef, 1024, Nil, False, ErrorRef)
		    If FileURL <> Nil And StartAccessingSecurityScopedResource(FileURL) Then
		      Declare Function Retain Lib "Cocoa" Selector "retain" (Target As Ptr) As Ptr
		      Call Retain(FileURL)
		      
		      Var Path As String = AbsoluteString(FileURL)
		      Var File As New BookmarkedFolderItem(Path, FolderItem.PathModes.URL)
		      File.mBookmark = FileURL
		      Return File
		    Else
		      Declare Function ErrorCode Lib "Cocoa" Selector "code" (Target As Ptr) As Integer
		      Declare Function ErrorDescription Lib "Cocoa" Selector "localizedDescription" (Target As Ptr) As CFStringRef
		      App.Log("Unable to resolve saveinfo for: " + Str(ErrorCode(ErrorRef)) + " " + ErrorDescription(ErrorRef))
		    End If
		  #else
		    Var File As FolderItem = FolderItem.DriveAt(0).FromSaveInfo(DecodeBase64(SaveInfo))
		    Return New BookmarkedFolderItem(File)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveInfo() As String
		  #if TargetiOS
		    Return ""
		  #elseif TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa" (ClassName As CString) As Ptr
		    Declare Function URLWithString Lib "Cocoa" Selector "URLWithString:" (Target As Ptr, URLString As CFStringRef) As Ptr
		    Declare Function BookmarkDataWithOptions Lib "Cocoa" Selector "bookmarkDataWithOptions:includingResourceValuesForKeys:relativeToURL:error:" (Target As Ptr, Options as UInt32, ResourceValuesKeys As Ptr, RelativeURL As Ptr, ByRef Error As Ptr) As Ptr
		    Declare Function DataLength Lib "Cocoa" Selector "length" (Target As Ptr) As UInteger
		    Declare Sub DataBytes Lib "Cocoa" Selector "getBytes:length:" (Target As Ptr, Buffer As Ptr, Length As UInteger)
		    
		    Var ErrorRef as Ptr
		    Var NSURL As Ptr = objc_getClass("NSURL")
		    Var FileURL As Ptr = URLWithString(NSURL, Self.URLPath)
		    If FileURL <> Nil Then
		      Var DataRef As Ptr = BookmarkDataWithOptions(FileURL, 2048, Nil, Nil, ErrorRef)
		      If DataRef <> Nil Then
		        Var Mem As New MemoryBlock(DataLength(DataRef))
		        DataBytes(DataRef, Mem, Mem.Size)
		        Return EncodeBase64(Mem, 0)
		      Else
		        Declare Function ErrorCode Lib "Cocoa" Selector "code" (Target As Ptr) As Integer
		        Declare Function ErrorDescription Lib "Cocoa" Selector "localizedDescription" (Target As Ptr) As CFStringRef
		        App.Log("Unable to get saveinfo for " + Self.NativePath + ": " + Str(ErrorCode(ErrorRef)) + " " + ErrorDescription(ErrorRef))
		      End If
		    End If
		  #else
		    Return EncodeBase64(Self.SaveInfo(Nil), 0)
		  #endif
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBookmark As Ptr
	#tag EndProperty


End Class
#tag EndClass
