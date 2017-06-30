#tag Class
Protected Class App
Inherits IOSApplication
	#tag CompatibilityFlags = TargetIOS
	#tag Method, Flags = &h0
		Function ApplicationSupport() As Xojo.IO.FolderItem
		  Dim AppSupport As Xojo.IO.FolderItem = Xojo.IO.SpecialFolder.ApplicationSupport
		  Dim CompanyFolder As Xojo.IO.FolderItem = AppSupport.Child("The ZAZ")
		  Self.CheckFolder(CompanyFolder)
		  Dim AppFolder As Xojo.IO.FolderItem = CompanyFolder.Child("Beacon")
		  Self.CheckFolder(AppFolder)
		  Return AppFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckFolder(Folder As Xojo.IO.FolderItem)
		  If Folder.Exists Then
		    If Not Folder.IsFolder Then
		      Folder.Delete
		      Folder.CreateAsFolder
		    End If
		  Else
		    Folder.CreateAsFolder
		  End If
		End Sub
	#tag EndMethod


	#tag Constant, Name = DocumentExtension, Type = Text, Dynamic = False, Default = \".beacon", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IdentityExtension, Type = Text, Dynamic = False, Default = \".beaconidentity", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PresetExtension, Type = Text, Dynamic = False, Default = \".beaconpreset", Scope = Public
	#tag EndConstant


End Class
#tag EndClass
