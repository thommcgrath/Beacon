#tag Class
Class BookmarkedFolderItem
Inherits FolderItem
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Shared Function CreateSaveInfo(File As FolderItem, Raw As Boolean = False) As String
		  If File Is Nil Then
		    Return ""
		  End If
		  
		  If File IsA BookmarkedFolderItem Then
		    Return BookmarkedFolderItem(File).SaveInfo(Raw)
		  End If
		  
		  Var Bookmark As New BookmarkedFolderItem(File)
		  Return Bookmark.SaveInfo(Raw)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Decode(Source As String) As MemoryBlock
		  If Source.IsEmpty Then
		    Return Nil
		  End If
		  
		  Var Tag As String = Source.Left(8)
		  If Tag.Compare("yrbq7ymg", ComparisonOptions.CaseSensitive) = 0 Then
		    // Minimized
		    Return Beacon.Decompress(DecodeBase64URLMBS(Source.Middle(8)))
		  End If
		  
		  Static Reg As Regex
		  If Reg Is Nil Then
		    Reg = New Regex
		    Reg.SearchPattern = "^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$"
		  End If
		  
		  If Reg.Search(Source) Is Nil Then
		    // Raw
		    Return Source
		  Else
		    // Legacy
		    Return DecodeBase64(Source)
		  End If
		End Function
	#tag EndMethod

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

	#tag Method, Flags = &h21
		Private Shared Function Encode(Mem As MemoryBlock, Version As Integer) As String
		  Select Case Version
		  Case VersionMinimized
		    // Minimized
		    Return "yrbq7ymg" + EncodeBase64URLMBS(Beacon.Compress(Mem))
		  Case VersionRaw
		    // Raw
		    Return Mem
		  Case VersionLegacy
		    // Legacy
		    Return EncodeBase64(Mem, 0)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveInfo(SaveInfo As String) As BookmarkedFolderItem
		  SaveInfo = Decode(SaveInfo)
		  
		  #if TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa" (ClassName As CString) As Ptr
		    Declare Function URLByResolvingBookmarkData Lib "Cocoa" Selector "URLByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:" (Target As Ptr, BookmarkData As Ptr, Options As UInt32, RelativeURL As Ptr, IsStale As Boolean, ByRef Error As Ptr) As Ptr
		    Declare Function DataWithBytes Lib "Cocoa" Selector "initWithBytes:length:" (Target As Ptr, Bytes As Ptr, Length As UInteger) As Ptr
		    Declare Function AbsoluteString Lib "Cocoa" Selector "absoluteString" (Target As Ptr) As CFStringRef
		    Declare Function Alloc Lib "Cocoa" Selector "alloc" (Target As Ptr) As Ptr
		    Declare Sub Autorelease Lib "Cocoa" Selector "autorelease" (Target As Ptr)
		    Declare Function StartAccessingSecurityScopedResource Lib "Cocoa" Selector "startAccessingSecurityScopedResource" (Target As Ptr) As Boolean
		    
		    Var Mem As MemoryBlock = SaveInfo
		    Var DataRef As Ptr = DataWithBytes(Alloc(objc_getClass("NSData")), Mem, CType(Mem.Size, UInteger))
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
		      App.Log("Unable to resolve saveinfo: " + ErrorCode(ErrorRef).ToString(Locale.Raw, "0") + " " + ErrorDescription(ErrorRef))
		    End If
		  #elseif TargetWindows Or TargetLinux
		    Try
		      Var File As FolderItem = FolderItem.FromSaveInfo(SaveInfo)
		      Return New BookmarkedFolderItem(File)
		    Catch Err As RuntimeException
		    End Try
		  #endif
		  
		  // Since it's not save info, let's treat it as a path
		  Try
		    Var File As New FolderItem(SaveInfo, FolderItem.PathModes.Native)
		    Return New BookmarkedFolderItem(File)
		  Catch Err As RuntimeException
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveInfo(Raw As Boolean = False) As String
		  Return Self.SaveInfo(If(Raw, Self.VersionRaw, Self.VersionMinimized))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveInfo(Version As Integer) As String
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
		        Var DataLen As UInteger = DataLength(DataRef)
		        Var Mem As New MemoryBlock(CType(DataLen, Integer))
		        DataBytes(DataRef, Mem, DataLen)
		        Return Encode(Mem, Version)
		      Else
		        Declare Function ErrorCode Lib "Cocoa" Selector "code" (Target As Ptr) As Integer
		        Declare Function ErrorDescription Lib "Cocoa" Selector "localizedDescription" (Target As Ptr) As CFStringRef
		        App.Log("Unable to get saveinfo for " + Self.NativePath + ": " + ErrorCode(ErrorRef).ToString(Locale.Raw, "0") + " " + ErrorDescription(ErrorRef))
		      End If
		    End If
		  #else
		    Return Encode(Self.SaveInfo(Nil), Version)
		  #endif
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBookmark As Ptr
	#tag EndProperty


	#tag Constant, Name = VersionLegacy, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VersionMinimized, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VersionRaw, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Count"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Exists"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ExtensionVisible"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Group"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="IsReadable"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsWriteable"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
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
			Name="Locked"
			Visible=false
			Group="Behavior"
			InitialValue="0"
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
			Name="NativePath"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Owner"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShellPath"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="URLPath"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsFolder"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Uint64"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsAlias"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
