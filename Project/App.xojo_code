#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub EnableMenuItems()
		  FileNew.Enable
		  FileOpen.Enable
		  FileImportConfig.Enable
		End Sub
	#tag EndEvent

	#tag Event
		Sub NewDocument()
		  Dim Win As New DocWindow
		  Win.Show
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Dim IdentityFile As FolderItem = Self.ApplicationSupport.Child("Default.arkidentity")
		  If IdentityFile.Exists Then
		    Dim Stream As BinaryStream = BinaryStream.Open(IdentityFile, False)
		    Dim Contents As String = DefineEncoding(Stream.Read(Stream.Length), Encodings.UTF8)
		    Stream.Close
		    
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Contents.ToText)
		    Dim Identity As Beacon.Identity = Beacon.Identity.Import(Dict)
		    Self.mIdentity = Identity
		  Else
		    Dim Identity As New Beacon.Identity
		    Dim Dict As Xojo.Core.Dictionary = Identity.Export
		    Dim Stream As BinaryStream = BinaryStream.Create(IdentityFile, False)
		    Stream.Write(Xojo.Data.GenerateJSON(Dict))
		    Stream.Close
		    Self.mIdentity = Identity
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  Dim Win As New DocWindow(Item)
		  Win.Show
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileImportConfig() As Boolean Handles FileImportConfig.Action
			Dim Dialog As New OpenDialog
			Dialog.Filter = BeaconFileTypes.IniFile
			
			Dim File As FolderItem = Dialog.ShowModal
			If File <> Nil Then
			Dim Win As New DocWindow
			Win.Show
			Win.Import(File)
			End If
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNew() As Boolean Handles FileNew.Action
			Self.NewDocument()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
			Dim Dialog As New OpenDialog
			Dialog.Filter = BeaconFileTypes.BeaconDocument
			
			Dim File As FolderItem = Dialog.ShowModal()
			If File <> Nil Then
			Self.OpenDocument(File)
			End If
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpAboutBeacon() As Boolean Handles HelpAboutBeacon.Action
			AboutWindow.Show
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function ApplicationSupport() As FolderItem
		  Dim AppSupport As FolderItem = SpecialFolder.ApplicationData
		  Dim CompanyFolder As FolderItem = AppSupport.Child("The ZAZ")
		  Self.CheckFolder(CompanyFolder)
		  Dim AppFolder As FolderItem = CompanyFolder.Child("Beacon")
		  Self.CheckFolder(AppFolder)
		  Return AppFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckFolder(Folder As FolderItem)
		  If Folder.Exists Then
		    If Not Folder.Directory Then
		      Folder.Delete
		      Folder.CreateAsFolder
		    End If
		  Else
		    Folder.CreateAsFolder
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DataSource() As ArkData
		  If Self.mDataSource = Nil Then
		    Self.mDataSource = New ArkData
		    Self.mDataSource.DatabaseFile = Self.ApplicationSupport.Child("Beacon.sqlite")
		    Call Self.mDataSource.Connect
		  End If
		  Return Self.mDataSource
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identity() As Beacon.Identity
		  Return Self.mIdentity
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDataSource As ArkData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
