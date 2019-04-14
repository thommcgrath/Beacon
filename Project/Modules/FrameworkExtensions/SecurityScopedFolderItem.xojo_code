#tag Class
Class SecurityScopedFolderItem
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
		Shared Function FromSaveInfo(SaveInfo As String) As FolderItem
		  #if TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa" (ClassName As CString) As Ptr
		    Declare Function URLByResolvingBookmarkData Lib "Cocoa" Selector "URLByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:" (Target As Ptr, BookmarkData As Ptr, Options As UInt32, RelativeURL As Ptr, IsStale As Boolean, ByRef Error As Ptr) As Ptr
		    Declare Function DataWithBytes Lib "Cocoa" Selector "initWithBytes:length:" (Target As Ptr, Bytes As Ptr, Length As UInteger) As Ptr
		    Declare Function AbsoluteString Lib "Cocoa" Selector "absoluteString" (Target As Ptr) As CFStringRef
		    Declare Function Alloc Lib "Cocoa" Selector "alloc" (Target As Ptr) As Ptr
		    Declare Sub Autorelease Lib "Cocoa" Selector "autorelease" (Target As Ptr)
		    Declare Function StartAccessingSecurityScopedResource Lib "Cocoa" Selector "startAccessingSecurityScopedResource" (Target As Ptr) As Boolean
		    
		    Dim Mem As MemoryBlock = DecodeBase64(SaveInfo)
		    Dim DataRef As Ptr = DataWithBytes(Alloc(objc_getClass("NSData")), Mem, Mem.Size)
		    Autorelease(DataRef)
		    
		    Dim ErrorRef As Ptr
		    Dim FileURL As Ptr = URLByResolvingBookmarkData(objc_getClass("NSURL"), DataRef, 1024, Nil, False, ErrorRef)
		    If FileURL <> Nil And StartAccessingSecurityScopedResource(FileURL) Then
		      Declare Function Retain Lib "Cocoa" Selector "retain" (Target As Ptr) As Ptr
		      Call Retain(FileURL)
		      
		      Dim Path As String = AbsoluteString(FileURL)
		      Dim File As New SecurityScopedFolderItem(Path, FolderItem.PathTypeURL)
		      File.mBookmark = FileURL
		      Return File
		    End If
		  #else
		    Dim StringValue As String = DecodeBase64(SaveInfo)
		    Dim File As FolderItem = Volume(0).GetRelative(StringValue)
		    Return File
		  #endif
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBookmark As Ptr
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AbsolutePath"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Alias"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Count"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Directory"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Exists"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ExtensionVisible"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Group"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsReadable"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsWriteable"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastErrorCode"
			Group="Behavior"
			InitialValue="0"
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
			Name="Locked"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacCreator"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacDirID"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacType"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacVRefNum"
			Group="Behavior"
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
			Name="NativePath"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Owner"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ResourceForkLength"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShellPath"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="Type"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="URLPath"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Group="Behavior"
			Type="Uint64"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mBookmark"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
