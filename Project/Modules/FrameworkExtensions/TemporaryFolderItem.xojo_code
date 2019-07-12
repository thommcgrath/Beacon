#tag Class
Class TemporaryFolderItem
Inherits FolderItem
	#tag Method, Flags = &h0
		Shared Function Create() As TemporaryFolderItem
		  Return New TemporaryFolderItem(SpecialFolder.Temporary.Child(EncodeHex(Crypto.GenerateRandomBytes(16))))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If Self.Exists Then
		    Call Self.DeepDelete
		  End If
		End Sub
	#tag EndMethod


End Class
#tag EndClass
